namespace E_Z80.Common
{
    public interface IOService
    {
        bool OpenSelectFolderDialog(string initialDir);

        string SelectedDirectory { get; }

        void ShowError(string errorMsg);
    }
}
