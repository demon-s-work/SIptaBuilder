using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using SiptaBuilder.Dal.Repositories.AuthRepository;
using SiptaBuilder.Dal.Repositories.EmployeeRepository;
using SiptaBuilder.Dal.Repositories.PositionRepository;
using SiptaBuilder.Dal.Settings;
using SiptaBuilder.Services;

namespace SiptaBuilder.Extensions
{
	public static class DiExtensions
	{
		public static void AddConfig(this IServiceCollection services, IConfigurationRoot configuration)
		{
			services.Configure<DbSettings>(configuration.GetSection(nameof(DbSettings)));
		}

		public static void ConfigureRepositories(this IServiceCollection services)
		{
			services.AddTransient<EmployeeRepository>();
			services.AddTransient<PositionRepository>();
			services.AddScoped<AuthRepository>();
		}

		public static void ConfigureServices(this IServiceCollection services)
		{
			services.AddScoped<AuthService>();
		}
	}
}