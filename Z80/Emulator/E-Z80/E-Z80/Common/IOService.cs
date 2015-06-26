namespace E_Z80.Common
{
    public interface IOService
    {
        bool OpenSelectFolderDialog(string _InitialDir);

        string SelectedDirectory { get; }

        void ShowError(string _ErrorMsg);
    }
}
