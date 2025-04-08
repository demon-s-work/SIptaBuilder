using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using Microsoft.Extensions.DependencyInjection;
using SiptaBuilder.Dal.Repositories.EmployeeRepository;
using SiptaBuilder.Dal.Repositories.PositionRepository;

namespace SiptaBuilder.Windows.EmployeeGroup
{
	public class EmployeeVm : BaseVm, INotifyPropertyChanged
	{
		public EmployeeVm(Employee employee)
		{
			FullName = employee.FullName;
			Login = employee.Login;
			Password = employee.Password;
			PositionId = employee.PositionId;
			_id = employee.Id;
			PropertyChanged += async (sender, args) => {
				var employeeRepo = Program.ServiceProvider.GetService<EmployeeRepository>();
				await employeeRepo.Update(new Employee()
				{
					Id = _id,
					Login = Login,
					FullName = FullName,
					Password = Password,
					PositionId = PositionId,
				});
			};
		}

		public int Id
		{
		get => _id;
		}
		
		
		
		public string Login
		{
			get => _login;
			set
			{
				_login = value;
				OnPropertyChanged();
			}
		}
		public string Password
		{
			get => _password;
			set
			{
				_password = value;
				OnPropertyChanged();
			}
		}
		public string FullName
		{
			get => _fullName;
			set
			{
				_fullName = value;
				OnPropertyChanged();
			}
		}

		public int PositionId
		{
			get => _positionId;
			set
			{
				_positionId = value;
				OnPropertyChanged();
			}
		}
		public ObservableCollection<Position> AvailablePositions
		{
			get => _positions;
			set
			{
				_positions = value;
				OnPropertyChanged();
			}
		}
		
		private ObservableCollection<Position> _positions = new ObservableCollection<Position>();
		private string _login;
		private string _password;
		private string _fullName;
		private int _positionId;
		public event PropertyChangedEventHandler? PropertyChanged;

		protected virtual void OnPropertyChanged([CallerMemberName] string? propertyName = null)
		{
			PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
		}

		protected bool SetField<T>(ref T field, T value, [CallerMemberName] string? propertyName = null)
		{
			if (EqualityComparer<T>.Default.Equals(field, value))
				return false;
			field = value;
			OnPropertyChanged(propertyName);
			return true;
		}
	}
}