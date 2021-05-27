using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace OnlineVotingApi.Models
{
    public class AssemblyConstituency
    {
        [Key]
        public int ConstituencyID { get; set; }

        public string ConstituencyNmae { get; set; }
        [ForeignKey("DistrictID")]
        public int DistrictID { get; set; }
    }
}
