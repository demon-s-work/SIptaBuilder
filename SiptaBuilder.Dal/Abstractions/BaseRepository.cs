using System.Data;
using Dapper;
using Dapper.Contrib.Extensions;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using MySql.Data.MySqlClient;
using SiptaBuilder.Dal.Settings;

namespace SiptaBuilder.Dal.Abstractions
{
	public abstract class BaseRepository<TEntity> : IRepository<TEntity> where TEntity : BaseEntity
	{
		private readonly string? _connectionString;

		protected BaseRepository(IOptionsMonitor<DbSettings> dbSettings, ILogger logger)
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

		public async Task<TEntity?> GetById<TEntity>(int id)
		{
			using var db = GetConnection();
			return (await db.QueryAsync($"Select * from {typeof(TEntity).Name + 's'} where Id = {id}")).SingleOrDefault();
		}

		public async Task<IEnumerable<TEntity>> GetAll()
		{
			using var db = GetConnection();
			var query = $"Select * from {typeof(TEntity).Name + 's'}";
			return (await db.QueryAsync<TEntity>(query)).AsEnumerable();
		}

		public virtual async Task Update(TEntity entity)
		{
			using var db = GetConnection();
			await db.UpdateAsync(entity);
		}

		public virtual async Task Add(TEntity entity)
		{
			using var db = GetConnection();
			await db.InsertAsync(entity);
		}

		public async Task Delete(int id)
		{
			using var db = GetConnection();
			await db.QueryAsync($"Delete from {typeof(TEntity).Name + 's'} where Id = {id}");
		}
	}
}