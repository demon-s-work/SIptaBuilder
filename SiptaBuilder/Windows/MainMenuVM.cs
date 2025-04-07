using System.ComponentModel;
using System.Runtime.CompilerServices;
using SiptaBuilder.Dal.Repositories.EmployeeRepository.Models;

namespace SiptaBuilder.Windows
{
	public class MainMenuVM : INotifyPropertyChanged
	{
		public Employee CurrentEmployee
		{
			get => _currentEmployee;
			set
			{
				_currentEmployee = value;
				OnPropertyChanged();
			}
		}
		
		private Employee _currentEmployee;
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