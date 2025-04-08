using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace SiptaBuilder.Windows
{
	public class BaseWindowVm<TViewModel> : INotifyPropertyChanged where TViewModel : BaseVm, INotifyPropertyChanged
	{
		public ObservableCollection<TViewModel> Entities
		{
			get => _entities;
			set
			{
				_entities = value;
				OnPropertyChanged();
			}
		}
		private ObservableCollection<TViewModel> _entities = new();
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