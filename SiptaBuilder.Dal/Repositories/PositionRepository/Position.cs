using SiptaBuilder.Dal.Abstractions;

namespace SiptaBuilder.Dal.Repositories.PositionRepository
{
	public class Position : BaseEntity
	{
		public string Title { get; set; }
		public Decimal Salary { get; set; }
		public int AccessLevel { get; set; }
	}
}