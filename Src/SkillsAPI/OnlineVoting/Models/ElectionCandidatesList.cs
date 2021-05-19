using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace OnlineVoting.Models
{
    public class ElectionCandidatesList
    {
        [Key]
        public int CandidateID { get; set; }
        public string CandidateName { get; set; }
        [ForeignKey("ConstituencyID")]
        public int candidateConstituency { get; set; }

      
    }
}
