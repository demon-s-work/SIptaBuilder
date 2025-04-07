using System.Windows;
using Microsoft.Extensions.DependencyInjection;
using SiptaBuilder.Windows;

namespace SiptaBuilder
{
	public class App : Application
	{
		readonly Window _window;
 
		public App()
		{
			_window = new LoginWindow();
		}
		
		protected override void OnStartup(StartupEventArgs e)
		{
			_window.Show();
			base.OnStartup(e);
		}
	}
}