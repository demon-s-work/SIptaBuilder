using SiptaBuilder.Dal.Abstractions;

namespace SiptaBuilder.Dal.Repositories.UserRepository.Models
{
	public class Position : BaseEntity
	{
		public string Title { get; set; }
		public decimal Salary { get; set; }
		public int AccessLevel { get; set; }
	}
}