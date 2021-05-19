using System;
using System.ComponentModel.DataAnnotations;

namespace OnlineVoting.Models
{
    public class State
    {
        [Key]
        public int StatedID { get; set; }

        public string StateName { get; set; }
    }
}
