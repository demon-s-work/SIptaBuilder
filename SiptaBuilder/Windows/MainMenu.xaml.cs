using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows;
using SiptaBuilder.Dal.Repositories.EmployeeRepository.Models;

namespace SiptaBuilder.Windows
{
	public partial class MainMenu
	{
		public MainMenu(Employee currentEmployee)
		{
			InitializeComponent();
			var vm = new MainMenuVM
			{
				CurrentEmployee = currentEmployee
			};
			DataContext = vm;

		}
	}
}