using System.IO;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using SiptaBuilder.Extensions;
using SiptaBuilder.Windows;

namespace SiptaBuilder;

static class Program
{
	[STAThread]
	static void Main()
	{
		var host = CreateHostBuilder().Build();
		ServiceProvider = host.Services;
		var app = ServiceProvider.GetService<App>();
		app?.Run();
	}

	public static IServiceProvider ServiceProvider { get; private set; }

	static IHostBuilder CreateHostBuilder()
	{
		var config = new ConfigurationBuilder()
		             .SetBasePath(Directory.GetCurrentDirectory())
		             .AddJsonFile("appsettings.json", reloadOnChange: true, optional: false)
		             .Build();

		return Host.CreateDefaultBuilder()
		           .ConfigureServices((context, services) => {
			           services.AddConfig(config);
			           services.ConfigureRepositories();
			           services.ConfigureServices();
			           services.AddTransient<App>();
		           })
		           .ConfigureLogging((context, builder) => {
			           builder.AddConsole();
		           });
	}
}