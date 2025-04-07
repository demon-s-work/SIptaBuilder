using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows;
using Microsoft.Extensions.DependencyInjection;
using SiptaBuilder.Services;

namespace SiptaBuilder.Windows
{
	public sealed partial class LoginWindow : Window
	{
		public LoginWindow()
		{
			InitializeComponent();
		}

		private void ShowErrorMessage(string message)
		{
			txtErrorMessage.Text = message;
			txtErrorMessage.Visibility = Visibility.Visible;
		}

		private void BtnCancel_Click(object sender, RoutedEventArgs e)
		{
			Close();
		}

		private async void BtnLogin_Click(object sender, RoutedEventArgs e)
		{
			var authService = Program.ServiceProvider.GetService<AuthService>();
			var user = await authService.Auth(txtUsername.Text, txtPassword.Password);
			if (user != null)
			{
				new MainMenu(user).Show();
				Close();
			}
			else
			{
				ShowErrorMessage("Invalid username or password");
			}

		}
	}
}