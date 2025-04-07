using System.Text.Json;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using SiptaBuilder.Dal.Repositories.AuthRepository;
using SiptaBuilder.Dal.Repositories.UserRepository;
using SiptaBuilder.Dal.Repositories.UserRepository.Models;
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
		public async Task<User?> Auth(string login, string password)
		{
			if (await authRepository.TryConnect(login, password))
			{
				dbSettings.CurrentValue.ConnectionString = string.Format(dbSettings.CurrentValue.ConnectionStringTemplate, login, password);
				var userRepository = Program.ServiceProvider.GetService(typeof(UserRepository)) as UserRepository;
				var user = await userRepository?.Authenticate(login, password.CreateMD5());

				return user;
			}
			return null;
		}
	}
}