namespace SiptaBuilder.Dal.Repositories.EmployeeRepository.Models
{
	public class Employee
	{
		public int EmployeeID {get; set;}
		public string Login { get; set; }
		public string PasswordHash { get; set; }
		public string FullName { get; set; }
	}
}