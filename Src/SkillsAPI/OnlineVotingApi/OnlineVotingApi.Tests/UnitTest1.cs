using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Moq;
using OnlineVotingApi.Controllers;
using OnlineVotingApi.Models;
using Xunit;

namespace OnlineVotingApi.Tests
{
    public class UnitTest1
    {
        public Mock<IOnlinevotingService> RepoMock = new Mock<IOnlinevotingService>();

        [Fact]
        public async void AadharDetailsExists_Test()
        {
            //Arrange
            var AadharCarddummy = new AadharCard()
            {
                AadharNumber = 765678945634,
                FirstName = "AadharFName_Dummy",
                LastName = "AadharLName_Dummy",
                Dob = "19-04-1991",
                PhoneNumber = "+919885801218",
                Address = "Dummy_Address",
                State = "Dummy_State",
                Pincode = 500083,
                Gender = "Male"

            };
            RepoMock.Setup(r => r.LoadAdharDetails(765678945634)).ReturnsAsync(AadharCarddummy);
            RegisterController user = new RegisterController(RepoMock.Object);
            //Act
            var result = await user.GetAadharDetails(765678945634);
            var okResult = result as ObjectResult;
            //Assert
            Assert.NotNull(okResult);
            Assert.True(okResult is OkObjectResult);
            Assert.IsType<AadharCard>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, okResult.StatusCode);

        }

        [Fact]
        public async void AadharDetailsDoesntExist_Test()
        {
            //Arrange
            RepoMock.Setup(r => r.LoadAdharDetails(56464534576864)).ReturnsAsync(new AadharCard { });
            RegisterController onlineVotingController = new RegisterController(RepoMock.Object);
            //Act
            var result = await onlineVotingController.GetAadharDetails(56464534576864) as ObjectResult;

            //Assert
            Assert.NotNull(result);
            Assert.True(result is OkObjectResult);
            Assert.IsType<AadharCard>(result.Value);
            Assert.Equal(StatusCodes.Status200OK, result.StatusCode);

        }
        [Fact]
        public async void RegisterVoter_Test()
        {
            int i = 0;
            var AadharCarddummy = new AadharCard()
            {
                AadharNumber = 654345678912,
                FirstName = "John",
                LastName = "AadharLName_Dummy",
                Dob = "19-04-1991",
                PhoneNumber = "+919885801218",
                Address = "Dummy_Address",
                State = "Dummy_State",
                Pincode = 500083,
                Gender = "Male"

            };
            var Voter = new Voter()
            {
                ID = 1,
                Aadharnumber = 654345678912,
                FName = "John",
                Registrationfromstate = "tElangana",
                VoterID = 78890098,
                Voted = false
            };

            RepoMock.Setup(r => r.RegisterVoter(654345678912, "Telanagana")).ReturnsAsync(Voter.VoterID);
            RegisterController onlineVotingController = new RegisterController(RepoMock.Object);
            var result = await onlineVotingController.VoterRegistration(654345678912, "Telanagana") as ObjectResult;
            Assert.NotEqual(0, i);
            Assert.Equal(StatusCodes.Status200OK, result.StatusCode);
        }

        [Fact]
        public void GenerateOtpOk_Test()
        {
            string dummyPhNumber = string.Empty;
            var AadharCarddummy = new AadharCard()
            {
                AadharNumber = 654345678912,
                FirstName = "vijendra",
                LastName = "AadharLName_Dummy",
                Dob = "19-04-1991",
                PhoneNumber = "+919885801218",
                Address = "Dummy_Address",
                State = "Dummy_State",
                Pincode = 500083,
                Gender = "Male"

            };
            var Voter = new Voter()
            {
                Aadharnumber = 678567432876,
                FName = "vijendra",
                Registrationfromstate = "Dummy_state",
                VoterID = 7867677,
                Voted = false
            };

            RepoMock.Setup(r => r.GenerateOtp(678567432876)).Returns(AadharCarddummy.PhoneNumber);
            RegisterController Controller = new RegisterController(RepoMock.Object);
            var result = Controller.GenerateOTP(Voter.Aadharnumber);
            var okResult = result as ObjectResult;
            Assert.True(okResult is ObjectResult);
            Assert.NotEqual(dummyPhNumber, okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, okResult.StatusCode);

        }

    }
}
