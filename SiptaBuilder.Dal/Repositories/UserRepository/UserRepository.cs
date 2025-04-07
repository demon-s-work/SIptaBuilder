using Dapper;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using SiptaBuilder.Dal.Abstractions;
using SiptaBuilder.Dal.Repositories.UserRepository.Models;
using SiptaBuilder.Dal.Settings;

namespace SiptaBuilder.Dal.Repositories.UserRepository
{
	public class UserRepository : BaseRepository
	{
		public UserRepository(IOptionsMonitor<DbSettings> dbSettings, ILogger<BaseRepository> logger) : base(dbSettings, logger)
		{
		}

		public async Task<List<User>> GetUsers()
		{
			using var db = GetConnection();
			return (await db.QueryAsync<User>("SELECT * FROM Users")).ToList();
		}

		public async Task<User?> Authenticate(string username, string passwordHash)
		{
			using var db = GetConnection();
			return (await db.QueryAsync<User>("SELECT * FROM Users WHERE Login = @username AND PasswordHash = @passwordHash"
				, new { username, passwordHash })).SingleOrDefault();
		}
	}
}