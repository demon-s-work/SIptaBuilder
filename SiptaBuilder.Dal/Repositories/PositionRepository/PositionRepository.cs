using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using SiptaBuilder.Dal.Abstractions;
using SiptaBuilder.Dal.Settings;

namespace SiptaBuilder.Dal.Repositories.PositionRepository
{
	public class PositionRepository : BaseRepository<Position>
	{
		public PositionRepository(IOptionsMonitor<DbSettings> dbSettings, ILogger<PositionRepository> logger) : base(dbSettings, logger)
		{
		}
	}
}