using System;
using System.ComponentModel.DataAnnotations;

namespace OnlineVotingApi.Models
{
    public class AadharCard
    {
        [Key]
        public long AadharNumber { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Dob { get; set; }
        public string PhoneNumber { get; set; }
        public string Address { get; set; }
        public string State { get; set; }
        public int Pincode { get; set; }
        public string Gender { get; set; }
    }
}
