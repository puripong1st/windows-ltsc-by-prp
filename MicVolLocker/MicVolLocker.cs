using System;
using System.Runtime.InteropServices;
using System.Threading;

namespace MicVolLocker
{
    class Program
    {
        [ComImport]
        [Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")]
        internal class MMDeviceEnumerator
        {
        }

        [Guid("A95664D2-9614-4F35-A746-DE8DB63617E6")]
        [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
        internal interface IMMDeviceEnumerator
        {
            [PreserveSig]
            int EnumAudioEndpoints(int dataFlow, int stateMask, out IMMDeviceCollection devices);
            
            [PreserveSig]
            int GetDefaultAudioEndpoint(int dataFlow, int role, out IMMDevice endpoint);
        }

        [Guid("0BD7A1CE-14DE-4358-A3B6-4810E0A2E259")]
        [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
        internal interface IMMDeviceCollection
        {
            [PreserveSig]
            int GetCount(out uint pcDevices);
            
            [PreserveSig]
            int Item(uint nDevice, out IMMDevice ppDevice);
        }

        [Guid("D666063F-1587-4E43-81F1-B948E807363F")]
        [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
        internal interface IMMDevice
        {
            [PreserveSig]
            int Activate(ref Guid iid, int dwClsCtx, IntPtr pActivationParams, [MarshalAs(UnmanagedType.IUnknown)] out object ppInterface);
        }

        [Guid("5CDF2C82-841E-4546-9722-0CF74078229A")]
        [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
        internal interface IAudioEndpointVolume
        {
            [PreserveSig]
            int RegisterControlChangeNotify(IntPtr pNotify);
            
            [PreserveSig]
            int UnregisterControlChangeNotify(IntPtr pNotify);
            
            [PreserveSig]
            int GetChannelCount(out uint pnChannelCount);
            
            [PreserveSig]
            int SetMasterVolumeLevel(float fLevelDB, ref Guid pguidEventContext);
            
            [PreserveSig]
            int SetMasterVolumeLevelScalar(float fLevel, ref Guid pguidEventContext);
            
            [PreserveSig]
            int GetMasterVolumeLevel(out float pfLevelDB);
            
            [PreserveSig]
            int GetMasterVolumeLevelScalar(out float pfLevel);
            
            [PreserveSig]
            int SetChannelVolumeLevel(uint nChannel, float fLevelDB, ref Guid pguidEventContext);
            
            [PreserveSig]
            int SetChannelVolumeLevelScalar(uint nChannel, float fLevel, ref Guid pguidEventContext);
            
            [PreserveSig]
            int GetChannelVolumeLevel(uint nChannel, out float pfLevelDB);
            
            [PreserveSig]
            int GetChannelVolumeLevelScalar(uint nChannel, out float pfLevel);
            
            [PreserveSig]
            int SetMute([MarshalAs(UnmanagedType.Bool)] bool bMute, ref Guid pguidEventContext);
            
            [PreserveSig]
            int GetMute([MarshalAs(UnmanagedType.Bool)] out bool pbMute);
            
            [PreserveSig]
            int GetVolumeStepInfo(out uint pnStep, out uint pnStepCount);
            
            [PreserveSig]
            int VolumeStepUp(ref Guid pguidEventContext);
            
            [PreserveSig]
            int VolumeStepDown(ref Guid pguidEventContext);
            
            [PreserveSig]
            int QueryHardwareSupport(out uint pdwHardwareSupportMask);
            
            [PreserveSig]
            int GetVolumeRange(out float pflVolumeMinDB, out float pflVolumeMaxDB, out float pflVolumeStepDB);
        }

        static void Main(string[] args)
        {
            float targetVolume = 1.0f; // 100%
            
            if (args.Length > 0)
            {
                float customVolVal;
                if (float.TryParse(args[0], out customVolVal))
                {
                    if (customVolVal >= 0f && customVolVal <= 100f)
                    {
                        targetVolume = customVolVal / 100f;
                    }
                }
            }
            
            Guid guidEmpty = Guid.Empty;
            Guid IID_IAudioEndpointVolume = new Guid("5CDF2C82-841E-4546-9722-0CF74078229A");
            
            while (true)
            {
                try
                {
                    var enumerator = (IMMDeviceEnumerator)new MMDeviceEnumerator();
                    // Enum active capture devices: eCapture = 1, DEVICE_STATE_ACTIVE = 1
                    IMMDeviceCollection devices;
                    int hr = enumerator.EnumAudioEndpoints(1, 1, out devices);
                    if (hr == 0 && devices != null)
                    {
                        uint count;
                        hr = devices.GetCount(out count);
                        if (hr == 0)
                        {
                            for (uint i = 0; i < count; i++)
                            {
                                IMMDevice device;
                                hr = devices.Item(i, out device);
                                if (hr == 0 && device != null)
                                {
                                    object volumeObj;
                                    hr = device.Activate(ref IID_IAudioEndpointVolume, 23, IntPtr.Zero, out volumeObj); // CLSCTX_ALL = 23
                                    if (hr == 0 && volumeObj != null)
                                    {
                                        var volume = (IAudioEndpointVolume)volumeObj;
                                        
                                        // Reset volume if it's different from target
                                        float currentVol;
                                        hr = volume.GetMasterVolumeLevelScalar(out currentVol);
                                        if (hr == 0 && Math.Abs(currentVol - targetVolume) > 0.001f)
                                        {
                                            volume.SetMasterVolumeLevelScalar(targetVolume, ref guidEmpty);
                                        }
                                        
                                        // Reset mute if it's muted
                                        bool muted;
                                        hr = volume.GetMute(out muted);
                                        if (hr == 0 && muted)
                                        {
                                            volume.SetMute(false, ref guidEmpty);
                                        }
                                        
                                        Marshal.ReleaseComObject(volume);
                                    }
                                    Marshal.ReleaseComObject(device);
                                }
                            }
                        }
                        Marshal.ReleaseComObject(devices);
                    }
                    Marshal.ReleaseComObject(enumerator);
                }
                catch
                {
                    // Ignore errors and keep running
                }
                
                Thread.Sleep(500); // Check every 500ms
            }
        }
    }
}
