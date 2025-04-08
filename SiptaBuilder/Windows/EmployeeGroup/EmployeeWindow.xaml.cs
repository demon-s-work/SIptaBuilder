using System.Collections.ObjectModel;
using System.Text.Json;
using System.Windows;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using SiptaBuilder.Dal.Repositories.EmployeeRepository;

namespace SiptaBuilder.Windows.EmployeeGroup
{
	public partial class EmployeeWindow : Window
	{
		public EmployeeWindow(IEnumerable<Employee> employees)
		{
			InitializeComponent();
			var vm = new EmployeeWindowVm(employees);

			vm.PropertyChanged += (s, e) => {
				var logger = Program.ServiceProvider.GetService<ILogger<EmployeeWindow>>();
			};

			DataContext = vm;
		}
	}
}