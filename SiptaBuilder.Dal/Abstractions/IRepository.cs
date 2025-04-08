namespace SiptaBuilder.Dal.Abstractions
{
	public interface IRepository<TEntity> where TEntity : BaseEntity
	{
		public Task<TEntity?> GetById<TEntity>(int id);
		public Task<IEnumerable<TEntity>> GetAll();
		public Task Update(TEntity entity);
		public Task Add(TEntity entity);
		public Task Delete(int id);
	}
}