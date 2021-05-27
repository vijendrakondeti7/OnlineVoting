using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using OnlineVotingApi.DataContext;
using OnlineVotingApi.Models;

namespace OnlineVotingApi.Service
{
    public class OnlineVotingService : IOnlinevotingService
    {
        private readonly OnlineVotingdbContext _context;
        private readonly IConfiguration _config;

        public OnlineVotingService(OnlineVotingdbContext onlineVotingdbContext,IConfiguration configuration)
        {
            _context = onlineVotingdbContext;
            _config = configuration;
        }


        public string GenerateOtp(long anumber)
        {
            string phonenumber = string.Empty;
            try
            {
                SqlParameter parameter = new SqlParameter("@Anumber", anumber);
                SqlParameter outParameter = new SqlParameter("@phonenumber", System.Data.SqlDbType.VarChar, 50);
                outParameter.Direction = System.Data.ParameterDirection.Output;
                string sql = "exec sp_getPhoneNumberfromaadhar @Anumber,@phonenumber output ";
                var result = _context.Database.ExecuteSqlRaw(sql, parameter, outParameter);
                return phonenumber = (string)outParameter.Value;



            }
            catch (Exception)
            {
                return phonenumber;


            }


        }


        public async Task<AadharCard> LoadAdharDetails(long aadharnumber)
        {
            AadharCard aadharCard = new();
            try
            {

                if (_context.DeceasedCandidates.FirstOrDefault(d => d.Aadharnumber == aadharnumber) == null)
                {
                    aadharCard = await _context.AadharCard.FindAsync(aadharnumber);
                }

                return aadharCard;
            }
            catch
            {
                return aadharCard;
            }
        }


        public async Task<int> RegisterVoter(long anumber, string state)
        {
            Voter voter = new();
            Random random = new();
            int voterId = random.Next(10000000, 99999999);
            var userName = _context.AadharCard.FirstOrDefault(a => a.AadharNumber == anumber).FirstName;
            var query = await _context.Voter.FirstOrDefaultAsync(v => v.Aadharnumber == anumber);
            if (query == null)

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


        public SecurityToken GenerateJWToken(long Anumber)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
            var tokenHandler = new JwtSecurityTokenHandler();
            try
            {
                var name = _context.Voter.FirstOrDefault(v => v.Aadharnumber == Anumber).FName;
                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new Claim[] {

                        new Claim("Aadharnumber", Anumber.ToString()),
                        new Claim(ClaimTypes.Name, name)
                    }),
                    Expires = DateTime.UtcNow.AddMinutes(5),
                    Issuer = _config["Jwt:Issuer"],
                    Audience = _config["Jwt:Issuer"],
                    SigningCredentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256)
                };
                SecurityToken token = tokenHandler.CreateToken(tokenDescriptor);
                return token;
            }
            catch (Exception)
            {
                return null;
            }

        }

        public async Task<List<ElectionCandidatesList>> GetCandiatesList(string sname, string district)
        {

            List<ElectionCandidatesList> electionCandidatesList = await (from e in _context.ElectionCandidatesList
                                                                         join a in _context.Assemblyconstituency on e.candidateConstituency equals a.ConstituencyID
                                                                         join d in _context.Districts on a.DistrictID equals d.DIstrictID
                                                                         join s in _context.States on d.StateID equals s.StatedID
                                                                         where d.DistrictName == district && s.StateName == sname
                                                                         select new ElectionCandidatesList
                                                                         {
                                                                             CandidateID = e.CandidateID,
                                                                             CandidateName = e.CandidateName
                                                                         }).ToListAsync();


            if (electionCandidatesList != null)
            {
                // _logger.LogInformation("There is data inside the list");


            }
            else
            {
                //_logger.LogError("there is no Data in the list");

            }


            return electionCandidatesList;
        }


        public bool SubmitVote(int cid, string votetoken, long anumber)
        {
            bool result = false;
            string nameFromToken = ValidToken(votetoken);
            Voter userdbDetails = _context.Voter.Where(u => u.FName == nameFromToken).Select(n => new Voter { FName = n.FName, Voted = n.Voted }).FirstOrDefault();
            if (userdbDetails.Voted == false && userdbDetails.FName == nameFromToken)
            {
                SubmittedVote submittedVote = new();
                submittedVote.CandID = cid;
                submittedVote.VoteToken = votetoken;
                _context.submittedVote.Add(submittedVote);
                if (_context.SaveChanges() == 1)
                {
                    Voter updateVoter = _context.Voter.Single(v => v.FName == nameFromToken);
                    updateVoter.Voted = true;
                    if (_context.SaveChanges() == 1)
                    {
                        result = true;
                    }


                }

            }
            return result;

        }


        public string ValidToken(string votetoken)
        {
            string name = string.Empty;
            try
            {

                JwtSecurityTokenHandler tokenHandler = new JwtSecurityTokenHandler();
                var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
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
            catch (Exception)
            {
                return name;
            }

        }


    }
}
