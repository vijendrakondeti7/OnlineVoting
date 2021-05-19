using System.Linq;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using OnlineVoting.Models;
namespace OnlineVoting
{
    public interface IOnlinVotingService
    {
        AadharCard LoadAdharDetails(long aadharnumber);
        int RegisterVoter(long aadharnumber, string state);
        int GenerateOtp(long anumber);
        SecurityToken GenerateJWToken(Voter voter);
        IQueryable<ElectionCandidatesList> GetCandiatesList(string state, string district);
        bool SubmitVote(int cid, string votetoken,Voter voter);
    }
}
