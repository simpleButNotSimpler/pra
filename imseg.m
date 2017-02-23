function [ out ] = imseg( img )

[ level, EM ] = graythresh( img );
BW = im2bw( img, level );
[ L, num ] = bwlabel( BW );

maxarea =  - Inf;
Lmax = 0;
for ii = 1:num
    numero = length( find( L == ii ) );
    if numero > maxarea
    maxarea = numero;
    Lmax = ii;
    end 
end 
ok = ( L == Lmax );


s = edge( double( ok ), 'canny', 0.5, 5 );
thinned = bwmorph( s, 'thin', Inf );
[ x0, y0 ] = find( thinned );
L = length( x0 );
radius = 70;
[ dimx, dimy ] = size( thinned );
matrice = zeros( dimx, dimy );
for scanx = 1:L
    xc = x0( scanx );
    yc = y0( scanx );

    x_s = max( 1, xc - radius );
    x_e = min( dimx, xc + radius );
    y_s = max( 1, yc - radius );
    y_e = min( dimy, yc + radius );

    for ii = x_s:x_e
        for jj = y_s:y_e
            if ok( ii, jj )
                r = sqrt( ( ii - xc ) ^ 2 + ( jj - yc ) ^ 2 );
                if r < radius
                matrice( xc, yc ) = matrice( xc, yc ) + 1;
                end 
            end 
        end 
    end 
end 


nz = 0;
glob_max = max( matrice( : ) );
my_thres = 0.7;
while nz < 3
    zone = matrice > my_thres * glob_max;
    zone = imdilate( zone, strel( 'disk', 2 ) );
    [ Lz, nz ] = bwlabel( zone );
    my_thres = my_thres - 0.25;
end 

if nz < 3
    error( 'Errore. Le zone di massimi relativi sono troppo poche.' );
end 
if nz == 3
    x = [  ];
    y = [  ];
for ii = 1:nz
    pos = find( Lz == ii );
    [ vmax, pmax ] = max( matrice( pos ) );
    mpos = pos( pmax );
    [ xm, ym ] = ind2sub( size( matrice ), mpos );
    x = [ x;xm ];
    y = [ y;ym ];
end 


x1 = x( 1 );
x2 = x( 2 );
x3 = x( 3 );
y1 = y( 1 );
y2 = y( 2 );
y3 = y( 3 );

d12 = sqrt( ( x1 - x2 ) ^ 2 + ( y1 - y2 ) ^ 2 );
d13 = sqrt( ( x1 - x3 ) ^ 2 + ( y1 - y3 ) ^ 2 );
d23 = sqrt( ( x2 - x3 ) ^ 2 + ( y2 - y3 ) ^ 2 );
if ( d12 > d13 ) && ( d12 > d23 )
    Ax = x1;
    Ay = y1;
    Bx = x2;
    By = y2;
end 
if ( d13 > d12 ) && ( d13 > d23 )
    Ax = x1;
    Ay = y1;
    Bx = x3;
    By = y3;
end 
if ( d23 > d12 ) && ( d23 > d13 )
    Ax = x2;
    Ay = y2;
    Bx = x3;
    By = y3;
end 


end 
if nz >= 4
    vettore_massimi = [  ];
    vettore_posizioni = [  ];
    for ii = 1:nz
        pos = find( Lz == ii );
        [ vmax, pmax ] = max( matrice( pos ) );
        mpos = pos( pmax );

        vettore_massimi = [ vettore_massimi;vmax ];
        vettore_posizioni = [ vettore_posizioni;mpos ];
    end 
    [ v_m_ord, indici ] = sort( vettore_massimi, 'descend' );
    v_p_ord = vettore_posizioni( indici );

    pos_fin = v_p_ord( 1:4 );

    [ x, y ] = ind2sub( size( matrice ), pos_fin );


    max_temp =  - Inf;
    v1memo = 0;
    v2memo = 0;
    v3memo = 0;
    v4memo = 0;

    v1 = 1;
    v2 = 2;
    v3 = 3;
    v4 = 4;
    p = polyfit( [ x( v1 ), x( v2 ), x( v3 ) ], [ y( v1 ), y( v2 ), y( v3 ) ], 1 );
    errore = p( 1 ) * x( v4 ) + p( 2 ) - y( v4 );
    errore = abs( errore );

    if errore > max_temp
        max_temp = errore;
        v1memo = v1;
        v2memo = v2;
        v3memo = v3;
        v4memo = v4;
    end 

    v1 = 1;
    v2 = 2;
    v3 = 4;
    v4 = 3;
    p = polyfit( [ x( v1 ), x( v2 ), x( v3 ) ], [ y( v1 ), y( v2 ), y( v3 ) ], 1 );
    errore = p( 1 ) * x( v4 ) + p( 2 ) - y( v4 );
    errore = abs( errore );

    if errore > max_temp
        max_temp = errore;
        v1memo = v1;
        v2memo = v2;
        v3memo = v3;
        v4memo = v4;
    end 

    v1 = 1;
    v2 = 3;
    v3 = 4;
    v4 = 2;
    p = polyfit( [ x( v1 ), x( v2 ), x( v3 ) ], [ y( v1 ), y( v2 ), y( v3 ) ], 1 );
    errore = p( 1 ) * x( v4 ) + p( 2 ) - y( v4 );
    errore = abs( errore );

    if errore > max_temp
        max_temp = errore;
        v1memo = v1;
        v2memo = v2;
        v3memo = v3;
        v4memo = v4;
    end 

    v1 = 2;
    v2 = 3;
    v3 = 4;
    v4 = 1;
    p = polyfit( [ x( v1 ), x( v2 ), x( v3 ) ], [ y( v1 ), y( v2 ), y( v3 ) ], 1 );
    errore = p( 1 ) * x( v4 ) + p( 2 ) - y( v4 );
    errore = abs( errore );

    if errore > max_temp
        max_temp = errore;
        v1memo = v1;
        v2memo = v2;
        v3memo = v3;
        v4memo = v4;
    end 

    x1 = x( v1memo );
    x2 = x( v2memo );
    x3 = x( v3memo );
    y1 = y( v1memo );
    y2 = y( v2memo );
    y3 = y( v3memo );

    d12 = sqrt( ( x1 - x2 ) ^ 2 + ( y1 - y2 ) ^ 2 );
    d13 = sqrt( ( x1 - x3 ) ^ 2 + ( y1 - y3 ) ^ 2 );
    d23 = sqrt( ( x2 - x3 ) ^ 2 + ( y2 - y3 ) ^ 2 );
    if ( d12 > d13 ) && ( d12 > d23 )
        Ax = x1;
        Ay = y1;
        Bx = x2;
        By = y2;
    end 
    if ( d13 > d12 ) && ( d13 > d23 )
        Ax = x1;
        Ay = y1;
        Bx = x3;
        By = y3;
    end 
    if ( d23 > d12 ) && ( d23 > d13 )
        Ax = x2;
        Ay = y2;
        Bx = x3;
        By = y3;
    end 
end 

p = polyfit( [ Ax, Bx ], [ Ay, By ], 1 );

STATS = regionprops( double( ok ), 'Centroid' );
baricentro = STATS.Centroid;
bary = round( baricentro( 1 ) );
barx = round( baricentro( 2 ) );


condizione = barx * p( 1 ) + p( 2 ) < bary;




clx = ( Ax + Bx ) / 2;
cly = ( Ay + By ) / 2;

c_a = p( 1 );
c_b = p( 2 );

c_a_new =  - 1 / c_a;
c_b_new = cly + 1 / c_a * clx;

d = 150;
t_a = 1 + c_a_new ^ 2;
t_b =  - 2 * clx + 2 * ( c_b_new - cly ) * c_a_new;
t_c = clx ^ 2 + ( c_b_new - cly ) ^ 2 - d ^ 2;

Px1 = (  - t_b + sqrt( t_b ^ 2 - 4 * t_a * t_c ) ) / ( 2 * t_a );
Py1 = c_a_new * Px1 + c_b_new;

Px2 = (  - t_b - sqrt( t_b ^ 2 - 4 * t_a * t_c ) ) / ( 2 * t_a );
Py2 = c_a_new * Px2 + c_b_new;

condizione_corrente = Px1 * p( 1 ) + p( 2 ) < Py1;
if condizione == condizione_corrente
    Px = Px1;
    Py = Py1;
else 
    Px = Px2;
    Py = Py2;
end 


angolo = atan( p( 1 ) );
[ dimx, dimy ] = size( matrice );
shiftx = Px - dimx / 2;
shifty = Py - dimy / 2;
shiftxnew = shiftx * cos( angolo ) + shifty * sin( angolo );
shiftynew =  - shiftx * sin( angolo ) + shifty * cos( angolo );
imgnew = imrotate( img,  - rad2deg( atan( p( 1 ) ) ), 'bilinear' );

% [ dimxnew, dimynew ] = size( imgnew );
% Pxnew = shiftxnew + dimxnew / 2;
% Pynew = shiftynew + dimynew / 2;
% 
% halfx = 80;
% halfy = 80;
% x0 = round( Pxnew );
% y0 = round( Pynew );
% croppedimage = imgnew( x0 - halfx:x0 + halfx, y0 - halfy:y0 + halfy );
% 
% out = croppedimage;
out = imgnew;
end