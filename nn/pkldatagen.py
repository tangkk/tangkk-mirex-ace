from acesongdb import pkl_data_nseg_h5py, pkl_data_framewise_h5py, pkl_data_nseg, pkl_data_framewise

pkl_data_framewise('../data/Jsong-ch-noinv.mat','../data/Jsong-ch-noinv.pkl')
pkl_data_framewise('../data/Bsong-ch-noinv.mat','../data/Bsong-ch-noinv.pkl')
pkl_data_nseg('../data/Jsong-ch-noinv.mat','../data/Jsong-6seg-ch-noinv.pkl',6)
pkl_data_nseg('../data/Bsong-ch-noinv.mat','../data/Bsong-6seg-ch-noinv.pkl',6)

pkl_data_framewise('../data/Bsong-ch-inv.mat','../data/Bsong-ch-inv.pkl')
pkl_data_nseg('../data/Bsong-ch-inv.mat','../data/Bsong-6seg-ch-inv.pkl',6)