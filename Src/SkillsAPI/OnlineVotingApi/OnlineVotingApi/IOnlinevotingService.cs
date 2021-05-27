using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.IdentityModel.Tokens;
using OnlineVotingApi.Models;

namespace OnlineVotingApi
{
    public interface IOnlinevotingService
    {
        Task<AadharCard> LoadAdharDetails(long aadharnumber);
        Task<int> RegisterVoter(long aadharnumber, string state);
        string GenerateOtp(long anumber);
        SecurityToken GenerateJWToken(long anumber);
        Task<List<ElectionCandidatesList>> GetCandiatesList(string state, string district);
        bool SubmitVote(int cid, string votetoken, long anumber);
    }
}
