using SiptaBuilder.Dal.Abstractions;

namespace SiptaBuilder.Dal.Repositories.EmployeeRepository
{
	public class Employee : BaseEntity
	{
		public string Login { get; set; }
		public string Password { get; set; }
		public string FullName { get; set; }
		public int PositionId { get; set; }
	}
}