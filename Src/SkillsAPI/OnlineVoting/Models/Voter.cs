using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace OnlineVoting.Models
{
    public class Voter
    {
        [Key]
        public int ID { get; set; }

        public string Registrationfromstate { get; set; }

        public int VoterID { get; set; }

        public string FName { get; set; }

        [ForeignKey("AadharNumber")]
        public long Aadharnumber { get; set; }

        public bool Voted { get; set; }


    }
}
