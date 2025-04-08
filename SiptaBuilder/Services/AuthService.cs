using System.Text.Json;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using SiptaBuilder.Dal.Repositories.AuthRepository;
using SiptaBuilder.Dal.Repositories.EmployeeRepository;
using SiptaBuilder.Dal.Settings;
using SiptaBuilder.Extensions;
using SiptaBuilder.Windows;

namespace SiptaBuilder.Services
{
	public class AuthService(
		AuthRepository authRepository,
		ILogger<AuthService> logger,
		IOptionsMonitor<DbSettings> dbSettings)
		
	{
		public async Task<Employee?> Auth(string login, string password)
		{
			if (await authRepository.TryConnect(login, password))
			{
				dbSettings.CurrentValue.ConnectionString = string.Format(dbSettings.CurrentValue.ConnectionStringTemplate, login, password);
				var userRepository = Program.ServiceProvider.GetService(typeof(EmployeeRepository)) as EmployeeRepository;
				var user = await userRepository?.Authenticate(login, password.CreateSha256());
				return user;
			}
			return null;
		}
	}
}