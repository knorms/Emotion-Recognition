for dset in ['train','val']:
	f = open('diff_%s.txt' % dset,'r')
	raw_pts_exp = f.readlines()
	raw_pts_exp = map(lambda sets: sets.split(), raw_pts_exp)
	raw_pts_exp = map(lambda sets: map(lambda val: float(val), sets), raw_pts_exp)

	f = open('emo_%s.txt' % dset,'r')
	lbls = f.read().split()
	lbls = map(lambda vals: float(vals), lbls)

	svm_input = []
	for i in range(len(raw_pts_exp)):
		svm_input.append([ raw_pts_exp[i], lbls[i] ] )
		
	import json
	with open('./clm_%sdata4node.txt' % dset, 'w') as outfile:
	    json.dump(svm_input, outfile)