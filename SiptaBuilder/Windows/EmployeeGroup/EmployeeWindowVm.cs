using System.Collections.ObjectModel;
using System.Text.Json;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using SiptaBuilder.Dal.Repositories.EmployeeRepository;
using SiptaBuilder.Dal.Repositories.PositionRepository;

namespace SiptaBuilder.Windows.EmployeeGroup
{
	public class EmployeeWindowVm : BaseWindowVm<EmployeeVm>
	{
		public EmployeeWindowVm(IEnumerable<Employee> employees)
		{
			Entities = new ObservableCollection<EmployeeVm>(employees.Select(e => new EmployeeVm(e)));
			Program.ServiceProvider.GetService<PositionRepository>()
				.GetAll()
				.ContinueWith(d => {
					//Program.ServiceProvider.GetService<ILogger<EmployeeWindowVm>>().LogInformation($"Recieved all positions {JsonSerializer.Serialize(d.Result)}");
					foreach (var ent in Entities)
					{
						ent.AvailablePositions = new ObservableCollection<Position>(d.Result);
					}
				});
		}

		public EmployeeWindowVm()
		{
		}
	}
}