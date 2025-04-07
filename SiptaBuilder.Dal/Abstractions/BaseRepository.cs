using System.Data;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using MySql.Data.MySqlClient;
using SiptaBuilder.Dal.Settings;

namespace SiptaBuilder.Dal.Abstractions
{
	public abstract class BaseRepository
	{
		private readonly string? _connectionString;

		protected BaseRepository(IOptionsMonitor<DbSettings> dbSettings, ILogger<BaseRepository> logger)
		{
			_connectionString = dbSettings.CurrentValue.ConnectionString;
			if (_connectionString.IsNullOrEmpty())
			{
				logger.LogCritical("No connection string configured.");
				//throw new ApplicationException("No connection string configured.");
			}
		}

		protected IDbConnection GetConnection()
		{
			return new MySqlConnection(_connectionString);
		}
	}
}