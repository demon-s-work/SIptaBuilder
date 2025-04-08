using Dapper;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using SiptaBuilder.Dal.Abstractions;
using SiptaBuilder.Dal.Settings;

namespace SiptaBuilder.Dal.Repositories.EmployeeRepository
{
	public class EmployeeRepository : BaseRepository<Employee>
	{
		public EmployeeRepository(IOptionsMonitor<DbSettings> dbSettings, ILogger<EmployeeRepository> logger) : base(dbSettings, logger)
		{
		}

		public async Task<Employee?> Authenticate(string username, string passwordHash)
		{
			using var db = GetConnection();
			return (await db.QueryAsync<Employee>("SELECT * FROM employees WHERE Login = @username AND Password = @passwordHash"
				, new { username, passwordHash })).SingleOrDefault();
		}
	}
}