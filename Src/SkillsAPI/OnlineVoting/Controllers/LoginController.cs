using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using OnlineVoting.Models;

namespace OnlineVoting.Controllers
{
    [Route("VotingModule")]
    [Authorize]
    public class LoginController : Controller
    {
        private readonly IOnlinVotingService _ionlinevotingservice;
        private readonly ILogger _logger;
        
        public LoginController(IOnlinVotingService onlinVotingService, ILogger<LoginController> logger,ILoggerFactory loggerFactory)
        {
            this._logger = loggerFactory.CreateLogger("OnlneVotingLogger");
            _ionlinevotingservice = onlinVotingService;
            _logger = logger;

        }

        [AllowAnonymous]
        [Route("AuthenticateUser")]
        [HttpGet]
        public IActionResult ValidateOtp(string otp, Voter voter)
        {
            try
            {
                _logger.LogInformation($"{DateTime.Now} :validateotp method started");
 
                
                string sessionOtp = HttpContext.Session.GetString("sessionotp");

                if (sessionOtp == otp)
                {
                    SecurityToken token = _ionlinevotingservice.GenerateJWToken(voter);
                    HttpContext.Session.SetString("SessioToken", token.ToString());
                    return Ok(new { token = new JwtSecurityTokenHandler().WriteToken(token) });
                }
                return Unauthorized();
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} :There Was an {ex.Message} while validating the Otp");
                return BadRequest();
            }

        }

        [Route("GetCandidateList")]
        [HttpGet]
        public IEnumerable<ElectionCandidatesList> GetCandidatesList(string sname, string dname)
        {
            
               _logger.LogInformation($"{DateTime.Now} :Getting the Candidates Details metthod has started");
                var result = _ionlinevotingservice.GetCandiatesList(sname, dname);
               

            
                //_logger.LogError($"{DateTime.Now} :Getcandidateslist method failed with {ex.InnerException}");
                
            
            return result;
        }


        [Route("SubmitVote")]
        [HttpPost]
        public IActionResult SubmitVote(int cid, Voter user, string token)
        {
            try
            {
                //_logger.LogInformation($"{DateTime.Now} :Submitting the vote method has Started");
                var tokenToBeValidated = HttpContext.Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();
                _logger.LogInformation(tokenToBeValidated);
                _logger.LogInformation(token);

                if (tokenToBeValidated == token)
                {
                    _logger.LogInformation("token validation against the user is started");

                    if (_ionlinevotingservice.SubmitVote(cid, tokenToBeValidated, user))
                    {
                        return Ok("You Have Voted Successfully");
                    }
                    else
                    {

                        return Ok("You Have already Voted");
                    }
                    
                }
                else
                {
                    return BadRequest("InvalidToken");
                }
                
            }
            catch(Exception ex)
            {
                _logger.LogError(ex.Message);
                return BadRequest("There Was an Issue While Submitting Your Vote");
            }
        }
    }
}
