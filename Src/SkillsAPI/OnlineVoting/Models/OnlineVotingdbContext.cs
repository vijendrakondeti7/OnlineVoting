using System;
using Microsoft.EntityFrameworkCore;

namespace OnlineVoting.Models
{
    public class OnlineVotingdbContext : DbContext
    {
        public OnlineVotingdbContext(DbContextOptions<OnlineVotingdbContext>options) : base(options)
        {

        }

        public DbSet<AadharCard> AadharCard { get; set; }
        public DbSet<Voter> Voter { get; set; }
        public DbSet<DeceasedCandidates> DeceasedCandidates { get; set; }
        public DbSet<State> States { get; set; }
        public DbSet<Districts> Districts { get; set; }
        public DbSet<AssemblyConstituency> Assemblyconstituency { get; set; }
        public DbSet<ElectionCandidatesList> ElectionCandidatesList { get; set; }
        public DbSet<SubmittedVote> submittedVote  { get; set; }
    }
}
