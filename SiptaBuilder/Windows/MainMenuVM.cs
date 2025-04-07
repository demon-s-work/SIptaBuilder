using System.ComponentModel;
using System.Runtime.CompilerServices;
using SiptaBuilder.Dal.Repositories.UserRepository.Models;

namespace SiptaBuilder.Windows
{
	public class MainMenuVM : INotifyPropertyChanged
	{
		public User CurrentUser
		{
			get => _currentUser;
			set
			{
				_currentUser = value;
				OnPropertyChanged();
			}
		}
		
		private User _currentUser;
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