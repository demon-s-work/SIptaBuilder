using SiptaBuilder.Dal.Abstractions;

namespace SiptaBuilder.Dal.Repositories.UserRepository.Models
{
	public class User : BaseEntity
	{
		public string Login { get; set; }
		public string PasswordHash { get; set; }
		public string Name { get; set; }
	}
}