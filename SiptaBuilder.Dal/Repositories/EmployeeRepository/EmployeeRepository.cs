using Dapper;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using SiptaBuilder.Dal.Abstractions;
using SiptaBuilder.Dal.Repositories.EmployeeRepository.Models;
using SiptaBuilder.Dal.Settings;

namespace SiptaBuilder.Dal.Repositories.EmployeeRepository
{
	public class EmployeeRepository : BaseRepository
	{
		public EmployeeRepository(IOptionsMonitor<DbSettings> dbSettings, ILogger<BaseRepository> logger) : base(dbSettings, logger)
		{
		}

		public async Task<List<Employee>> GetUsers()
		{
			using var db = GetConnection();
			return (await db.QueryAsync<Employee>("SELECT * FROM Employees")).ToList();
		}

		public async Task<Employee?> Authenticate(string username, string passwordHash)
		{
			using var db = GetConnection();
			return (await db.QueryAsync<Employee>("SELECT * FROM Employees WHERE Login = @username AND Password = @passwordHash"
				, new { username, passwordHash })).SingleOrDefault();
		}
	}
}