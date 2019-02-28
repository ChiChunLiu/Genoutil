'''
format convertion
'''

def np2allel(x):
    '''
    convert 2d numpy array into scikit allele
    compatible 3d numpy array
    2 -> [1, 1]
    0 -> [0, 0]
    1 -> [0, 1]
    '''
    x1 = np.copy(x)
    x1[x1 == 1] = 0
    x1[x1 == 2] = 1
    
    x2 = np.copy(x)
    x2[x2 == 2] = 1
    
    return np.stack((x1,x2), axis = -1)


#numpy.unpackbits(myarray, axis=None)
#numpy.packbits(myarray, axis=None)

'''
tokenization
'''

chrom_digit = {'X':23, 'Y':24, 'chrM': 90, 'MT':90, 'M': 90, 'XY':91, '0': 0}
for c in list(range(1,23)):
    chrom_digit[str(c)] = int(c)

sex_token = {'Female': 'F', 'Male': 'M',
             '1': 'M', '2': 'F'}

def digitize_chrom(chrom, chrom_digitize_dict = chrom_digit):
    '''mapping chromosome from {'1'..'22','X','Y','MT'} to {1~24,90}
    '''
    return chrom_digitize_dict[chrom]

def tokenize_sex(sex, token_dict = sex_token):
    if sex in sex_token.keys():
        return sex_token[sex]
    else:
        return 'U'

'''
strand util
'''
base_complement = {"A": "T", "T": "A", "C": "G", "G": "C"}


'''
Miscellaneous
'''
def progressBar(bar_length, value, total):
    '''
    Prints a simple progress bar denoting progress in a for loop
    '''

    frac = value/total
    prog = '+' * int(round(frac * bar_length))
    space = ' ' * (bar_length - len(prog))

    sys.stdout.write('\rProgress: [{0}] {1:2.2f}%'.format('+' + prog + space, frac*100))
    sys.stdout.flush()
