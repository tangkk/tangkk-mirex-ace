from acesongdb import pkl_data_nseg_h5py, pkl_data_framewise_h5py, pkl_data_nseg, pkl_data_framewise, pkl_data_varlen, pkl_data_varlen_h5py, pkl_data_matrix, pkl_data_waveform_h5py

####################################### ch ############################################
# ymax = 61 #noinv
# pkl_data_framewise('../data/ch/Jsong-ch-noinv.mat','../data/ch/Jsong-ch-noinv.pkl',ymax)
# pkl_data_framewise('../data/ch/Bsong-ch-noinv.mat','../data/ch/Bsong-ch-noinv.pkl',ymax)
# pkl_data_nseg('../data/ch/Jsong-ch-noinv.mat','../data/ch/Jsong-6seg-ch-noinv.pkl',6,ymax)
# pkl_data_nseg('../data/ch/Bsong-ch-noinv.mat','../data/ch/Bsong-6seg-ch-noinv.pkl',6,ymax)

# ymax = 277 #inv
# pkl_data_framewise('../data/ch/Jsong-ch-inv.mat','../data/ch/Jsong-ch-inv.pkl', ymax)
# pkl_data_nseg('../data/ch/Jsong-ch-inv.mat','../data/ch/Jsong-6seg-ch-inv.pkl',6, ymax)
# pkl_data_framewise('../data/ch/Bsong-ch-inv.mat','../data/ch/Bsong-ch-inv.pkl', ymax)
# pkl_data_nseg('../data/ch/Bsong-ch-inv.mat','../data/ch/Bsong-6seg-ch-inv.pkl',6, ymax)

# ymax = 73 #no7
# pkl_data_framewise('../data/ch/Jsong-ch-no7.mat','../data/ch/Jsong-ch-no7.pkl', ymax)
# pkl_data_nseg('../data/ch/Jsong-ch-no7.mat','../data/ch/Jsong-6seg-ch-no7.pkl',6, ymax)
# pkl_data_framewise('../data/ch/Bsong-ch-no7.mat','../data/ch/Bsong-ch-no7.pkl', ymax)
# pkl_data_nseg('../data/ch/Bsong-ch-no7.mat','../data/ch/Bsong-6seg-ch-no7.pkl',6, ymax)

# no need to pkl pure matrix .mat file for the moment, since it can be handled quite nicely in scipy.io
# pkl_data_matrix('../data/ch/J6seg-ch-inv.mat','../J6seg-ch-inv.pkl')
# pkl_data_matrix('../data/ch/J6seg-ch-noinv.mat','../J6seg-ch-noinv.pkl')
# pkl_data_matrix('../data/ch/B6seg-ch-inv.mat','../B6seg-ch-inv.pkl')
# pkl_data_matrix('../data/ch/B6seg-ch-noinv.mat','../B6seg-ch-noinv.pkl')

# pkl variable length data
# pkl_data_varlen('../data/ch/Jvarlen-ch-inv.mat','../data/ch/J6varlen-ch-inv.pkl',24,1)
# pkl_data_varlen('../data/ch/Jvarlen-ch-noinv.mat','../data/ch/J6varlen-ch-noinv.pkl',24,1)
# pkl_data_varlen('../data/ch/Bvarlen-ch-inv.mat','../data/ch/B6varlen-ch-inv.pkl',24,1)
# pkl_data_varlen('../data/ch/Bvarlen-ch-noinv.mat','../data/ch/B6varlen-ch-noinv.pkl',24,1)

####################################### ns ############################################
# ymax = 277 #inv
# pkl_data_framewise_h5py('../data/ns/Jsong-ns-inv.mat','../data/ns/Jsong-ns-inv.pkl', ymax)
# pkl_data_nseg_h5py('../data/ns/Jsong-ns-inv.mat','../data/ns/Jsong-6seg-ns-inv.pkl',6, ymax)

# ymax = 61 #noinv
# pkl_data_framewise_h5py('../data/ns/Jsong-ns-noinv.mat','../data/ns/Jsong-ns-noinv.pkl',ymax)
# pkl_data_nseg_h5py('../data/ns/Jsong-ns-noinv.mat','../data/ns/Jsong-6seg-ns-noinv.pkl',6,ymax)

# ymax = 73 #no7
# pkl_data_framewise_h5py('../data/ns/Jsong-ns-no7.mat','../data/ns/Jsong-ns-no7.pkl', ymax)
# pkl_data_nseg_h5py('../data/ns/Jsong-ns-no7.mat','../data/ns/Jsong-6seg-ns-no7.pkl',6, ymax)

####################################### sg ############################################
# ymax = 277 #inv
# pkl_data_framewise_h5py('../data/sg/Jsong-sg-inv.mat','../data/sg/Jsong-sg-inv.pkl', ymax)

####################################### wf ############################################
# ymax = 277 #inv
# pkl_data_waveform_h5py('../data/wf/Jsong-wf-inv.mat','../data/wf/Jsong-wf-inv.pkl', ymax)