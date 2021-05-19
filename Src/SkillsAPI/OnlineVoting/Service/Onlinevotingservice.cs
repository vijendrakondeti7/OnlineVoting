using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using OnlineVoting.Models;
using Twilio;
using Twilio.Rest.Api.V2010.Account;

namespace OnlineVoting.Service
{
    public class Onlinevotingservice : IOnlinVotingService
    {
        private readonly OnlineVotingdbContext _context;
        private readonly IConfiguration _config;
        private readonly ILogger _logger;
        public Onlinevotingservice(OnlineVotingdbContext context, IConfiguration configuration, ILoggerFactory loggerFactory)
        {
            _context = context;
            _config = configuration;
            _logger = loggerFactory.CreateLogger("ONLINEVOTINGLOGGER");

        }
        /// <summary>
        /// Generating Otp for Sign In
        /// </summary>
        /// <param name="anumber"></param>
        /// <returns></returns>
        public int GenerateOtp(long anumber)
        {
            int otp = 0;
            try
            {

                var phoneNumbers = _context.AadharCard.Join(_context.Voter, a => a.AadharNumber, v => v.Aadharnumber, (a, v) => new { a.PhoneNumber }).Single();
                Random random = new();
                otp = random.Next(100000, 999999);
                string message = $"your otp for login is :{otp}";
                Sendotp(phoneNumbers.PhoneNumber, message);
                return otp;
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} There Was an {ex.Message} Exception While Genaerating an OTP ");
                return otp;

            }

        }
        /// <summary>
        /// Sending OTP to Users Mobile For Sign In
        /// </summary>
        /// <param name="phonenumbers"></param>
        /// <param name="message"></param>
        /// <returns></returns>

        private static bool Sendotp(string phonenumbers, string message)
        {
            try
            {
                string accountSid = "ACe0002f4a27bfa6e2fb9a8fb2c946bf53";
                string authToken = "0f2d99aaa5f011cb66aff9562eb6a94c";
                string from = "+15612645618";
                TwilioClient.Init(accountSid, authToken);
                MessageResource response = MessageResource.Create(
                    body: message,
                    from: from,
                    to: new Twilio.Types.PhoneNumber(phonenumbers)
                );
                return true;
            }
            catch
            {

                return false;
            }

        }
        /// <summary>
        /// Retrieving Aadhar Details From Aadhar DB
        /// </summary>
        /// <param name="aadharnumber"></param>
        /// <returns></returns>
        public AadharCard LoadAdharDetails(long aadharnumber)
        {
            AadharCard aadharCard = new();
            try
            {
                _logger.LogInformation($"{DateTime.Now} :Getting Aadhar Details for {aadharnumber}");
                return _context.DeceasedCandidates.FirstOrDefault(d => d.Aadharnumber == aadharnumber) == null
                    ? _context.AadharCard.SingleOrDefault(a => a.AadharNumber == aadharnumber)
                    : aadharCard;
            }
            catch
            {
                //_logger.LogError($"{DateTime.Now} :There was an {ex.Message} while Loading Aadhar Details");
                return aadharCard;
            }
        }

        /// <summary>
        /// Registering User For Online Voting
        /// </summary>
        /// <param name="anumber"></param>
        /// <param name="state"></param>
        /// <returns></returns>
        public int RegisterVoter(long anumber, string state)
        {
            Voter voter = new();
            Random random = new();
            int voterId = random.Next(10000000, 99999999);
            var userName = _context.AadharCard.FirstOrDefault(a => a.AadharNumber == anumber).FirstName;
            if (_context.Voter.FirstOrDefault(v => v.Aadharnumber == anumber) == null)

            {
                voter.Aadharnumber = anumber;
                voter.Registrationfromstate = state;
                voter.VoterID = voterId;
                voter.FName = userName;
                _context.Voter.Add(voter);

                if (_context.SaveChanges() == 1)
                {

                    return voterId;
                }
            }
            return 0;
        }
        /// <summary>
        /// Generating JWT Token for Authentication for voting module
        /// </summary>
        /// <param name="voter"></param>
        /// <returns></returns>

        public SecurityToken GenerateJWToken(Voter voter)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
            var tokenHandler = new JwtSecurityTokenHandler();
            try
            {
                _logger.LogInformation($"{DateTime.Now} :Generarting Jwt Token");

                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new Claim[] {

                    new Claim(ClaimTypes.Name,voter.FName.ToString())
                }),
                    Expires = DateTime.UtcNow.AddMinutes(5),
                    Issuer = _config["Jwt:Issuer"],
                    Audience = _config["Jwt:Issuer"],
                    SigningCredentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256)
                };
                SecurityToken token = tokenHandler.CreateToken(tokenDescriptor);
                return token;
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} : There was an {ex.Message} while generating the Jwt Token");
                return null;
            }

        }

        /// <summary>
        /// loading the electing candidates list for voting from users aasembly constituency using his state name and district
        /// </summary>
        /// <param name="sname"></param>
        /// <param name="district"></param>
        /// <returns></returns>
        public IQueryable<ElectionCandidatesList> GetCandiatesList(string sname, string district)
        {

            IQueryable<ElectionCandidatesList> electionCandidatesList = from e in _context.ElectionCandidatesList
                                     join a in _context.Assemblyconstituency on e.candidateConstituency equals a.ConstituencyID
                                     join d in _context.Districts on a.DistrictID equals d.DIstrictID
                                     join s in _context.States on d.StateID equals s.StatedID
                                     where d.DistrictName == district && s.StateName == sname
                                     select new ElectionCandidatesList
                                     {
                                         CandidateID = e.CandidateID,
                                         CandidateName = e.CandidateName
                                     };
            _logger.LogInformation(electionCandidatesList.ToString());

            if (electionCandidatesList != null)
            {
                _logger.LogInformation("There is data inside the list");
               

            }
            else
            {
                _logger.LogError("there is no Data in the list");

            }


            return electionCandidatesList;
        }

        /// <summary>
        /// Submitting users vote
        /// </summary>
        /// <param name="cid"></param>
        /// <param name="votetoken"></param>
        /// <param name="voter"></param>
        /// <returns></returns>
        public bool SubmitVote(int cid, string votetoken, Voter voter)
        {
            bool result = false;
            _logger.LogInformation($"{DateTime.Now} :Inside SubmitVote method");
            string Name = ValidToken(votetoken);
            var checkifVoted = _context.Voter.Where(u => u.FName == Name).FirstOrDefault().Voted ? true : false;
            if (checkifVoted == false && voter.FName == Name)
            {
                SubmittedVote submittedVote = new();
                submittedVote.CandID = cid;
                submittedVote.VoteToken = votetoken;
                _context.submittedVote.Add(submittedVote);
                if (_context.SaveChanges() == 1)
                {

                    Voter updateVoter = _context.Voter.Single(v => v.FName == Name);
                    updateVoter.Voted = true;
                    if (_context.SaveChanges() == 1)
                    {
                        _logger.LogInformation("Vote details are saved");
                        result = true;
                    }

                    
                }

            }
            return result;

        }
        /// <summary>
        /// Validating Token against the User while submitting the vote
        /// </summary>
        /// <param name="votetoken"></param>
        /// <returns></returns>

        public string ValidToken(string votetoken)
        {
            string name = string.Empty;
            try
            {
            _logger.LogInformation($"{DateTime.Now} :Inside valid token method");
            JwtSecurityTokenHandler tokenHandler = new JwtSecurityTokenHandler();
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
            _logger.LogInformation($"{DateTime.Now} : Validating the JWT Token against the user");
            tokenHandler.ValidateToken(votetoken, new TokenValidationParameters
            {
                ValidateIssuerSigningKey = true,
                ValidateIssuer = true,
                ValidateAudience = true,
                ValidIssuer = _config["Jwt:Issuer"],
                ValidAudience = _config["Jwt:Issuer"],
                IssuerSigningKey = securityKey,
            }, out SecurityToken validatedToken);
            var securityToken = tokenHandler.ReadToken(votetoken) as JwtSecurityToken;
            name = securityToken.Claims.First(claim => claim.Type == "unique_name").Value;
            return name;

            }
            catch(Exception ex)
            {
                _logger.LogError($"{ex.Message} {name}");
                return name;
            }

        }
    }
}
