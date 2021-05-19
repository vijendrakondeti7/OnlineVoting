using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace OnlineVoting.Models
{
    public class DeceasedCandidates
    {
        [Key]
        public int  Id { get; set; }
        public string DateOfDeath { get; set; }
        [ForeignKey("AadharNumber")]
        public long Aadharnumber { get; set; }
    }


}
