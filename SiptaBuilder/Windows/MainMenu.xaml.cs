using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows;
using SiptaBuilder.Dal.Repositories.UserRepository.Models;

namespace SiptaBuilder.Windows
{
	public partial class MainMenu
	{
		public MainMenu(User currentUser)
		{
			InitializeComponent();
			var vm = new MainMenuVM
			{
				CurrentUser = currentUser
			};
			DataContext = vm;

		}
	}
}