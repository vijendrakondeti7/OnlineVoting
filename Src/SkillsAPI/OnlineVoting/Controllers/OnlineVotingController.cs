using System;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace OnlineVoting.Controllers
{
    [Route("Register")]
    public class OnlineVotingController : Controller
    {
        private readonly IOnlinVotingService _ionlinevotingservice;
        private readonly ILogger _logger;
        public OnlineVotingController(IOnlinVotingService onlinVotingService, ILogger<OnlineVotingController> logger)
        {
            _ionlinevotingservice = onlinVotingService;
            _logger = logger;

        }

        [Route("GetAadharDetails")]
        [HttpGet]
        public IActionResult GetAadharDetails(long Anumber)
        {
            try
            {
                var AadharDetails = _ionlinevotingservice.LoadAdharDetails(Anumber);
                if (AadharDetails != null)
                {
                    return Ok(AadharDetails);

                }
                else
                {
                    _logger.LogInformation($"{ DateTime.Now} :there were no records found");
                    return BadRequest("No Records Were Found");
                }

            }
            catch(Exception ex)
            {
                _logger.LogError($"{ DateTime.Now} :there were an Exception While Retrieving Aadhar Details with {ex.Message}");
                return BadRequest();
            }


        }

        [Route("VoterRegistration")]
        [HttpPost]
        public IActionResult VoterRegistration(long AdharNumber, string state)
        {
            try
            {

                return _ionlinevotingservice.RegisterVoter(AdharNumber, state) != 0 ?Ok() : NoContent();

            }
            catch (Exception ex)
            {
                _logger.LogError($"{ DateTime.Now} :there were an Exception While Retrieving an User with { ex.Message}");
                return BadRequest();
            }



        }
        [Route("GenerateOTP")]
        [HttpGet]
        public IActionResult GenerateOTP(long anumber)
        {
            try
            {
                int result = _ionlinevotingservice.GenerateOtp(anumber);
                HttpContext.Session.SetString("sessionotp", result.ToString());
                return Ok(result);
            }

            catch(Exception ex)
            {
                _logger.LogError($"{ DateTime.Now} :there were an Exception While Generating an OTP with an {ex.Message}");
                return BadRequest();
            }

        }



    }
}
