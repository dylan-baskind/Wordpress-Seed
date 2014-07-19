<article class='post' id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
	<div class='hero'>
		<a class='title' href="<?php the_permalink(); ?>">
			<header class="entry-header">
				<?php the_title( '<h1 class="entry-title">', '</h1>' ); ?>
			</header><!-- .entry-header -->
		</a>
		

		<a class='feature-image' href="<?php the_permalink(); ?>">
			<figure>
				<?php the_post_thumbnail('large'); ?>
			</figure>
			<div class='hover-tile'>
				<div class='text'>
					Read this story
					<span class='icon-arrow-right'></span>
				</div>
			</div>
		</a>
	</div>

	<div class="excerpt">
		<!-- Summary -->
		<p class='summary'>
			<?php the_excerpt(); ?>
		</p>
		<?php
			wp_link_pages( array(
				'before' => '<div class="page-links">' . __( 'Pages:', '_mbbasetheme' ),
				'after'  => '</div>',
			) );
		?>
	</div>
	
</article>
