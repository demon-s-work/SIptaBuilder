using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using MySql.Data.MySqlClient;
using SiptaBuilder.Dal.Settings;

namespace SiptaBuilder.Dal.Repositories.AuthRepository
{
	public class AuthRepository(IOptions<DbSettings> dbSettings, ILogger<AuthRepository> logger)
	{
		public async Task<bool> TryConnect(string login, string password)
		{
			using var conn = new MySqlConnection(string.Format(dbSettings.Value.ConnectionStringTemplate, login, password));
			try
			{
				await conn.OpenAsync();
			}
			catch (MySqlException e)
			{
				logger.LogError(e.Message);
				return false;
			}
			return true;
		}
	}
}