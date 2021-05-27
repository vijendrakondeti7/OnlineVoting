using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using OnlineVotingApi.Models;


// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace OnlineVotingApi.Controllers
{
    [Route("VotingModule")]
    [Authorize]
    public class VotingModuleController : Controller
    {
        private readonly IOnlinevotingService _ionlinevotingservice;
        public VotingModuleController(IOnlinevotingService onlinevotingService)
        {
            _ionlinevotingservice = onlinevotingService;
        }
        [AllowAnonymous]
        [Route("AuthenticateUser")]
        [HttpGet]
        public IActionResult ValidateOtp(string otp, long anumber)
        {
            try
            {
               
                string sessionOtp = HttpContext.Session.GetString("sessionotp");

                if (sessionOtp == otp)
                {
                    SecurityToken token = _ionlinevotingservice.GenerateJWToken(anumber);
                    HttpContext.Session.SetString("SessioToken", token.ToString());
                    return Ok(new { token = new JwtSecurityTokenHandler().WriteToken(token) });
                }
                return Unauthorized();
            }
            catch (Exception ex)
            {
                //_logger.LogError($"{DateTime.Now} :There Was an {ex.Message} while validating the Otp");
                return BadRequest(ex.Message);
            }

        }
        [Route("GetCandidateList")]
        [HttpGet]
        public IEnumerable<ElectionCandidatesList> GetCandidatesList(string sname, string dname)
        {

            //_logger.LogInformation($"{DateTime.Now} :Getting the Candidates Details metthod has started");
            var result = _ionlinevotingservice.GetCandiatesList(sname, dname);

            return (IEnumerable<ElectionCandidatesList>)result;
        }

        [Route("SubmitVote")]
        [HttpPost]
        public ActionResult SubmitVote(int cid, long anumber, string token)
        {
            try
            {
                var tokenToBeValidated = HttpContext.Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();
                if (tokenToBeValidated == token)
                {
                    //_logger.LogInformation("token validation against the user is started");

                    return _ionlinevotingservice.SubmitVote(cid, tokenToBeValidated, anumber)
                        ? Ok("You Have Voted Successfully")
                        : Ok("You Have already Voted");

                }
                else
                {
                    return BadRequest("InvalidToken");
                }

            }
            catch (Exception ex)
            {
                //_logger.LogError(ex.Message);
                return BadRequest($"There Was an Issue While Submitting Your Vote: {ex.Message}");
            }
        }
    }
}
