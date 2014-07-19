<section class='post-list row'>
	<div class='medium-6 columns medium-centered'>
		<?php while ( have_posts() ) : the_post(); ?>

			<?php get_template_part( 'content', 'page' ); ?>

		<?php endwhile; ?>
		
		<div class='pagination'>
			<?php echo paginate_links( $args ); ?>
		</div>
	
	</div>
</section>
