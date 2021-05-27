using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace OnlineVotingApi.Models
{
    public class Districts
    {
        [Key]
        public int DIstrictID { get; set; }
        public string DistrictName { get; set; }
        [ForeignKey("StatedID")]
        public int StateID { get; set; }
    }
}
