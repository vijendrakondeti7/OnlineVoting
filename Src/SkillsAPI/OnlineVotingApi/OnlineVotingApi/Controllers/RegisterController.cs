using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OnlineVotingApi.Models;
using Twilio;
using Twilio.Rest.Api.V2010.Account;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace OnlineVotingApi.Controllers
{
    [Route("Register")]
    public class RegisterController : Controller
    {
        private readonly IOnlinevotingService _ionlinevotingservice;
        public RegisterController(IOnlinevotingService onlinevotingService)
        {
            _ionlinevotingservice = onlinevotingService;
        }

        [Route("GetAadharDetails")]
        [HttpGet]
        public async Task<ActionResult> GetAadharDetails(long Anumber)
        {
            try
            {

                AadharCard AadharDetails = await _ionlinevotingservice.LoadAdharDetails(Anumber);
                return AadharDetails != null ? Ok(AadharDetails) : Ok("No Records Were Found");

            }
            catch (Exception)
            {

                return BadRequest();
            }


        }

        [Route("VoterRegistration")]
        [HttpPost]
        public async Task<ActionResult> VoterRegistration([FromQuery] long AdharNumber, string state)
        {
            try
            {
                var voterID = await _ionlinevotingservice.RegisterVoter(AdharNumber, state);
                return voterID != 0 ? Ok(voterID) : BadRequest();

            }
            catch (Exception)
            {
                return BadRequest();
            }



        }
        [Route("GenerateOTP")]
        [HttpGet]
        public IActionResult GenerateOTP([FromQuery] long anumber)
        {
            try
            {
                string phoneNumber = _ionlinevotingservice.GenerateOtp(anumber);
                if (phoneNumber != null)
                {
                    bool result = Sendotp(phoneNumber);
                    return Ok(result);
                }
                else
                {
                    return BadRequest(false);
                }
            }

            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }
        private bool Sendotp(string phonenumbers)
        {

            try
            {
                Random random = new();
                int otp = random.Next(100000, 999999);
                string message = $"your otp for login is :{otp}";
                string accountSid = "ACe0002f4a27bfa6e2fb9a8fb2c946bf53";
                string authToken = "0f2d99aaa5f011cb66aff9562eb6a94c";
                string from = "+15612645618";
                TwilioClient.Init(accountSid, authToken);
                MessageResource response = MessageResource.Create(
                   body: message,
                   from: from,
                   to: new Twilio.Types.PhoneNumber(phonenumbers)
               );
                HttpContext.Session.SetString("sessionotp", otp.ToString());
                return true;
            }
            catch
            {

                return false;
            }

        }
    }
}
