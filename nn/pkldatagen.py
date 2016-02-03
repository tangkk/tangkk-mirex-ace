from acesongdb import pkl_data_nseg_h5py, pkl_data_framewise_h5py, pkl_data_nseg, pkl_data_framewise, pkl_data_varlen, pkl_data_varlen_h5py, pkl_data_matrix


# ymax = 61 #noinv
# pkl_data_framewise('../data/Jsong-ch-noinv.mat','../data/Jsong-ch-noinv.pkl',ymax)
# pkl_data_framewise('../data/Bsong-ch-noinv.mat','../data/Bsong-ch-noinv.pkl',ymax)
# pkl_data_nseg('../data/Jsong-ch-noinv.mat','../data/Jsong-6seg-ch-noinv.pkl',6,ymax)
# pkl_data_nseg('../data/Bsong-ch-noinv.mat','../data/Bsong-6seg-ch-noinv.pkl',6,ymax)

# ymax = 277 #inv
# pkl_data_framewise('../data/Jsong-ch-inv.mat','../data/Jsong-ch-inv.pkl', ymax)
# pkl_data_nseg('../data/Jsong-ch-inv.mat','../data/Jsong-6seg-ch-inv.pkl',6, ymax)
# pkl_data_framewise('../data/Bsong-ch-inv.mat','../data/Bsong-ch-inv.pkl', ymax)
# pkl_data_nseg('../data/Bsong-ch-inv.mat','../data/Bsong-6seg-ch-inv.pkl',6, ymax)

# ymax = 73 #no7
# pkl_data_framewise('../data/Jsong-ch-no7.mat','../data/Jsong-ch-no7.pkl', ymax)
# pkl_data_nseg('../data/Jsong-ch-no7.mat','../data/Jsong-6seg-ch-no7.pkl',6, ymax)
# pkl_data_framewise('../data/Bsong-ch-no7.mat','../data/Bsong-ch-no7.pkl', ymax)
# pkl_data_nseg('../data/Bsong-ch-no7.mat','../data/Bsong-6seg-ch-no7.pkl',6, ymax)

# no need to pkl pure matrix .mat file for the moment, since it can be handled quite nicely in scipy.io
# pkl_data_matrix('../data/J6seg-ch-inv.mat','../J6seg-ch-inv.pkl')
# pkl_data_matrix('../data/J6seg-ch-noinv.mat','../J6seg-ch-noinv.pkl')
# pkl_data_matrix('../data/B6seg-ch-inv.mat','../B6seg-ch-inv.pkl')
# pkl_data_matrix('../data/B6seg-ch-noinv.mat','../B6seg-ch-noinv.pkl')

# pkl variable length data
# pkl_data_varlen('../data/Jvarlen-ch-inv.mat','../data/J6varlen-ch-inv.pkl',24,1)
# pkl_data_varlen('../data/Jvarlen-ch-noinv.mat','../data/J6varlen-ch-noinv.pkl',24,1)
# pkl_data_varlen('../data/Bvarlen-ch-inv.mat','../data/B6varlen-ch-inv.pkl',24,1)
# pkl_data_varlen('../data/Bvarlen-ch-noinv.mat','../data/B6varlen-ch-noinv.pkl',24,1)
