using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace OnlineVoting.Models
{
    public class SubmittedVote
    {
        [Key]
        public int VoteID { get; set; }
        public string VoteToken { get; set;}
        [ForeignKey("CandidateID")]
        public int CandID { get; set;}
    }
}
