using System.Windows;
using Microsoft.Extensions.DependencyInjection;
using SiptaBuilder.Dal.Repositories.EmployeeRepository;

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

		private async void ButtonBase_OnClick(object sender, RoutedEventArgs e)
		{
			var employeeRepository = Program.ServiceProvider.GetService<EmployeeRepository>();
			new EmployeeGroup.EmployeeWindow(await employeeRepository.GetAll()).Show();
		}
	}
}